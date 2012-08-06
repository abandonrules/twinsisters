FireBall = class('FireBall')

FireBall.anim = {}

FireBall.img_right = love.graphics.newImage('sprites/fireball_right.png')
FireBall.img_right:setFilter("nearest","nearest")
FireBall.anim.right = newAnimation(FireBall.img_right, 32, 32, 0.01, 0)

FireBall.img_left = love.graphics.newImage('sprites/fireball_left.png')
FireBall.img_left:setFilter("nearest","nearest")
FireBall.anim.left = newAnimation(FireBall.img_left, 32, 32, 0.01, 0)

FireBall.particle = love.graphics.newImage('sprites/fire_particle.png')
FireBall.particle:setFilter("nearest","nearest")

FireBall.instances = 0

function FireBall:initialize(player)
  self.player = player
  self.direction = self.player.direction
  self.w = self.player.w
  self.x = self.direction == 'left' and self.player.x - 15 or self.player.x + 15
  self.y = self.player.y
  self.z = self.player.z

  self.xspeed = 2.5

  self.display = true

  self.animation = FireBall.anim[self.direction]

  self.body = Collider:addCircle(self.x, self.y, 3)
  self.body.parent = self

  CRON.after(0.75, function() FireBall.destroy(self) end)

  FireBall.instances = FireBall.instances + 1

  --self.ps = love.graphics.newParticleSystem(FireBall.particle, 99)
  --self.ps:setEmissionRate          (10)
  --self.ps:setLifetime              (10)
  --self.ps:setParticleLife          (0.3)
  --self.ps:setDirection             (0)
  --self.ps:setSpread                (math.pi*2)
  --self.ps:setSpeed                 (40)
  --self.ps:setGravity               (0)
  --self.ps:setRadialAcceleration    (0)
  --self.ps:setTangentialAcceleration(100)
  --self.ps:setSizeVariation         (1000)
  --self.ps:setRotation              (0)
  --self.ps:setSpin                  (0)
  --self.ps:setSpinVariation         (0)
  --self.ps:start()
end

function FireBall:update(dt)
  if self.direction == 'left'  then self.x = self.x - self.xspeed end
  if self.direction == 'right' then self.x = self.x + self.xspeed end

  self.animation:update(dt / FireBall.instances)

  --self.ps:update(dt)
  --self.ps:setPosition(self.x, self.y)

  self.body:moveTo(self.x, self.y)
end

function FireBall:draw()
  --love.graphics.draw(self.ps, 0, 0)
  self.animation:draw(self.x-16, self.y-16)
end

function FireBall:onCollision(dt, shape, dx, dy)
  -- Get the other shape parent (its game object)
  local o = shape.parent

  -- Do nothing if the object belongs to another dimention
  if o.w ~= nil and o.w ~= self.w and self.w ~= nil then return end

  -- Collision with most objects
  if o.class.name == 'Wall'
  or o.class.name == 'FlyingWall'
  or o.class.name == 'Bridge'
  or o.class.name == 'Arrow'
  or o.class.name == 'Ice'
  or o.class.name == 'Spike'
  or o.class.name == 'Sword'
  or o.class.name == 'Crab'
  or o.class.name == 'Slant' then
    self.x = self.x - dx
    self.xspeed = 0
    --TEsound.play('sounds/explosion.wav')
    self:destroy()
  end

end

function FireBall:destroy()
  Collider:remove(self.body)
  objects[self.name] = nil
  --self.ps = nil
  FireBall.instances = FireBall.instances - 1
end