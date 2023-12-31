
void makeFireParticle(Vec2f pos)
{
	string texture;
	texture = "/particle_trail_blue.png";

	ParticleAnimated(texture, pos, Vec2f(0, 0), 0.0f, 1.0f, 1, 0.01, true);
}

void makeSmokeParticle(Vec2f pos, f32 gravity = 0.0f)
{
	string texture;
	texture = "/particle_firesmoke.png";

	ParticleAnimated(texture, pos, Vec2f(0, 0), 0.0f, 1.0f, 3, gravity, true);
}