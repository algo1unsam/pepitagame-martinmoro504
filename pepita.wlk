import example.*
import extras.*
import wollok.game.*

object pepita {

	var property energia = 100
	var property position = game.origin()

	method image() {
		return if (self.estaEnElNido()){
			 "pepita-grande.png"
			 }
			 else if (self.esAtrapada() or self.estaCansada()){
				"pepita-gris.png"
			 }
			 else{
				"pepita.png"
			 }
	}

	method esAtrapada()=self.position()==silvestre.position()

	method come(comida) {
		energia = energia + comida.energiaQueOtorga()
		game.removeVisual(comida)
	}

	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		if(self.tieneEnergia()){
			if(self.esVisible(nuevaPosicion)){
				self.vola(position.distance(nuevaPosicion))
				position = nuevaPosicion}
		}else{
			game.say(self, "Me canse:()")
			game.schedule(2000, { game.stop() })
		}
	}
	
	method esVisible(posicion)=posicion.x().between(0,9) and posicion.y().between(0,9)

	method tieneEnergia()= energia>0

	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}
	
	
	method estaEnElSuelo() {
		return position.y() == 0 
	}

	method baja(){
		if(self.esVisibleEnY()){
		position = position.down(1)}
	}

	method esVisibleEnY(){
		return self.position().y().between(1,9) 
	}
}

