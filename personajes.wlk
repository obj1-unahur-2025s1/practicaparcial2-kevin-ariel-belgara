class Personaje{
   const property  fuerza
   const inteligencia
   var property rol
   method potencialOfensivo()= fuerza * 10 + rol.extra()
   method esGroso() = self.esInteligente() || self.esGrosoEnSuRol()
   method esInteligente()
   method esGrosoEnSuRol() = rol.esGroso(self)
}
class Orco inherits Personaje{
    method esBrujo() = rol == brujo
    override method potencialOfensivo()=if(self.esBrujo()) super() * 1.1 else super()
    override method esInteligente()= false

}
class Humano inherits Personaje{
    override method esInteligente()= inteligencia > 50
    
}
object guerrero{
    method extra()= 100
    method esGroso(unPersonaje)= unPersonaje.fuerza() > 50
}
class Cazador{
    const property mascota
    method extra()= mascota.extra()
    method esGroso(unPersonaje)=mascota.esLongeva()
}
object brujo{
    method extra()=0
    method esGroso(unPersonaje)=true
}
class Mascota{
    const property fuerza
    var edad
    const property  tieneGarras
    method extra()= if(tieneGarras) 2 * fuerza else fuerza
    method esLongeva()= edad > 10
    
}
class Localidad{
   var ejercito 
   method poderDefensivo()=ejercito.poderOfensivo() 
   method ejercito()= ejercito
   method serOcupadaPor(unEjercito)
}
class Aldea inherits Localidad{
   const cantidadMaximaHabitantes
   
   override  method serOcupadaPor(unEjercito){
     if(unEjercito.personajes().size() > cantidadMaximaHabitantes){
        ejercito = ejercito.ejercitoMasFuerte()
     }
     else{ 
      ejercito = unEjercito
     }
   }

}
class Ciudad inherits Localidad{
   override method poderDefensivo()=super()+ 300
    override method serOcupadaPor(unEjercito){
      ejercito = unEjercito
   }
   
}
class Ejercito{
    const property personajes = []
    method puedeInvadir(unaLocalidad){
        return self.poderOfensivo() > unaLocalidad.poderDefensivo()
    }
    method invadir(unaLocalidad){
       if (self.puedeInvadir(unaLocalidad)){
          unaLocalidad.serOcupadaPor(self)
       }
    }
    method poderOfensivo(){
        return personajes.sum({personaje => personaje.potencialOfensivo()})
    }
    method ordenadosLosMasPoderosos(){
        return personajes.sortBy({p1,p2 => p1.potencialOfensivo() > p2.potencialOfensivo()})
    }
    method ejercitoMasFuerte(){
        return self.ordenadosLosMasPoderosos().take(10)
    }
}
