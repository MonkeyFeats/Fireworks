
string teamcol;
void onInit(CBlob@ this)
{
	this.set_u32("timer", 30);

	switch (XORRandom(8))
	{
		case 0: teamcol = "blue"; break;
		case 1: teamcol = "darkblue"; break;
		case 2: teamcol = "green"; break;
		case 3: teamcol = "grey"; break;
		case 4: teamcol = "orange"; break;
		case 5: teamcol = "purple"; break;
		case 6: teamcol = "teal"; break;		
		case 7: teamcol = "red"; break;
	}	
}

void onTick(CBlob@ this)
{
	u32 timer = this.get_u32("timer");
	timer--;
	this.set_u32("timer", timer);

	if (timer == 0)
	{
		splode(this);
	}

	ParticleAnimated("/particle_trail_"+teamcol+".png", this.getPosition(), Vec2f(0, 0), 0.0f, 1.0f, 1, 0.01, true);
}

void splode(CBlob@ this)
{
	if (getNet().isServer())
	{
		CBlob @blob = server_CreateBlob("fw_explosion");
		if (blob !is null)
		{
			//SetScreenFlash( 30, 0, 0, 150 ); // done in expolsion.as for the colours
			blob.AddScript("FW_Explosion.as");
			blob.setPosition(this.getPosition());
			blob.setVelocity(this.getVelocity());
		}
	}
		
	string explodesound;

	switch (XORRandom(4))
	{
		case 0: explodesound = "FW_Deep1.ogg"; break;
		case 1: explodesound = "FW_Deep2.ogg"; break;
		case 2: explodesound = "FW_Deep3.ogg"; break;
		case 3: explodesound = "FW_PopAndCrackle.ogg"; break;
	}
    //Sound::Play(explodesound, this.getPosition());
    Sound::Play2D(explodesound, 0.4f + (XORRandom(6)*0.1), 0.5); // its everywhere   

	this.server_Die();
	
}
