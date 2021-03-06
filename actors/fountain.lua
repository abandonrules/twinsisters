Fountain = class('Fountain')

Fountain.light_particle = love.graphics.newImage('sprites/light_particle.png')
Fountain.light_particle:setFilter("nearest","nearest")

function Fountain:initialize(x, y, z)
  self.x = x + 16
  self.y = y + 16
  self.z = 10

  self.light = love.graphics.newParticleSystem(Fountain.light_particle, 99)
  self.light:setEmissionRate          (50)
  self.light:setLifetime              (10)
  self.light:setParticleLife          (5)
  self.light:setDirection             (0)
  self.light:setSpread                (50)
  self.light:setSpeed                 (100)
  self.light:setGravity               (20)
  self.light:setRadialAcceleration    (10)
  self.light:setTangentialAcceleration(0)
  self.light:setSizeVariation         (1)
  self.light:setRotation              (0)
  self.light:setSpin                  (1)
  self.light:setSpinVariation         (3)
  self.light:start()
end

function Fountain:update(dt)
  self.light:update(dt)
  self.light:setPosition(self.x, self.y)
end

function Fountain:drawhallo()
  love.graphics.draw(self.light, 0, 0)
end
