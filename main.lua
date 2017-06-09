function love.load()
	L = 640
	EI = 10000000
	cargas = {}
end


function q(x)
	return 1
end

function qx(x)
	return q(x)*x
end

function F(x)
	return cargas[x] or 0
end

function Fx(x)
	return F(x)*x
end

function r2()
	return (integral(Fx,0,L,1)+integral(qx,0,L,1))/L
end

function r1()
	return integral(q,0,L,1) + integral(F,0,L,1) - r2()
end 

function M(x)
	return (integral(Fx,0,x,1)+integral(qx,0,x,1)-r2()*x)/1000
end

function v(x)
	return (integral(M,0,x,1)*x*x/2-integral(M,0,L,1)*x*L/2)/EI
end

function integral(f,a,b,delta)
	soma = 0
	for x=a,b,delta do
		soma=soma+f(x)*delta
	end
	
	return soma
end


function integral2(f,a,b,delta)
	soma = 0
	for x=a,b,delta do
		soma=soma+f(x)*delta*delta
	end
	
	return soma	
end


function Q(x)
	return integral(q,0,x,1) + integral(F,0,x,1)-r1()
end

print(Q)

function love.mousepressed(x,y,b,t)
	cargas[x]=300-y
end

function love.draw()
	love.graphics.setColor(255,0,0,255)
	love.graphics.line(love.mouse.getX(),love.mouse.getY(),love.mouse.getX(),300)

	love.graphics.setColor(128,128,0,255)
	for x,y in pairs(cargas) do
		love.graphics.line(x,300-y,x,300)
	end

	love.graphics.setColor(0,255,0,255)
	love.graphics.line(0,300,L,300)
	for i=0,L,1 do
		love.graphics.setColor(0,0,255,255)
		love.graphics.line(i,300+v(i),i+1,300+v(i+1))
	end

	for i=0,L,1 do
		love.graphics.setColor(0,140,140,255)
		love.graphics.line(i,300+M(i),i+1,300+M(i+1))
	end
	for i=0,L,1 do
		love.graphics.setColor(100,100,100,255)
		love.graphics.line(i,300+Q(i),i+1,300+Q(i+1))
	end	
	
end
