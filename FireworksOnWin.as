
void onTick(CRules@ this)
{
	if (this.isGameOver())
	{
		/* this is some next level shit.
		u16 randomtime;
		if (getGameTime() % 30 == 0) 
		{ randomtime = (XORRandom(30)+60); }

		if (getGameTime() % randomtime == 0) 
		{ */
		CMap@ map = getMap();
		u16 delay = this.get_u16("fireworks time");
		u8 r = this.get_u8("rand");


		if (map !is null)
		{
			f32 side = (XORRandom(2) == 0 ? -8 : 8);
			f32 mapMid = ((map.tilemapwidth+side) * map.tilesize)/2;
			Vec2f spawnpos = Vec2f(mapMid, map.getLandYAtX(mapMid / map.tilesize) * map.tilesize - 64.0f);	

			if (delay == 0)
			{				
				this.set_u8("rand", 30+XORRandom(60));
			}

			if (delay < 90)
			{
				delay++;
				this.set_u16("fireworks time", delay);
			}		

			if (delay ==  r) 
			{	
				if (getNet().isServer())
				{
					CBlob@ fireworks = server_CreateBlob("fw_bullet");
					if (fireworks !is null)
					{	
						fireworks.setPosition(spawnpos);
						Vec2f vel = Vec2f(-10+XORRandom(20), -10 -XORRandom(10));
						fireworks.setVelocity(vel);
					}
				}

				string launchsound;
				switch (XORRandom(3))
				{
					case 0: launchsound = "FW_Whistle1.ogg"; break;
					case 1: launchsound = "FW_Whistle2.ogg"; break;
					case 2: launchsound = "FW_Launch.ogg"; break;
				}
				Sound::Play(launchsound, spawnpos, 0.6f);

				this.set_u16("fireworks time", 0);				
			}
		}
	}
}
