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
import paciente.*

describe "group of tests for centro de Kinesiologia" {
  const leonardo = new Paciente(edad=40,dolor=10,fortalezaMuscular=20)
  const milena = new Paciente(edad=3,dolor=30,fortalezaMuscular=50)
  const magneto1 = new Magneto()
  const bici1 = new Bicicleta()
  const mini1= new Minitramp()
  test "Leonardo puede usar el magneto" {
    assert.that(leonardo.puedeUsar(magneto1))
  }
  test "Leonardo puede usar la bici" {
     assert.that(leonardo.puedeUsar(bici1))
  }
  test "Leonardo puede usar el minitramp" {
     assert.that(leonardo.puedeUsar(mini1))
  }
   test "Milena puede usar el magneto" {
    assert.that(leonardo.puedeUsar(magneto1))
  }
  test "Milena no puede usar la bici" {
     assert.notThat(milena.puedeUsar(bici1))
  }
  test "Milena no puede usar el minitramp" {
     assert.notThat(milena.puedeUsar(mini1))
  }
  test"Despues de usar el magneto una vez,el nivel de dolor de Leonardo baja a 9"{
    leonardo.usar(magneto1)
    assert.equals(9,leonardo.dolor())
  }
  test"Despues de usar el magneto una vez,el nivel de dolor de Milena baja a 27"{
    milena.usar(magneto1)
    assert.equals(27,milena.dolor())
  }
  test "Después de usar la bicicleta una vez, el nivel de dolor de Leonardo baja a 6, y la fortaleza sube a 23"{
    leonardo.usar(bici1)
     assert.equals(6,leonardo.dolor())
      assert.equals(23,leonardo.fortalezaMuscular())
  }
}
class Paciente{
    var edad
    var fortalezaMuscular
    var  dolor 
    method dolor()= dolor
    method edad()=edad
    method fortalezaMuscular()=fortalezaMuscular 
    method disminuirDolor(valor){
       dolor = 0.max(dolor - valor)
    }
    method aumentarFortaleza(valor){
        fortalezaMuscular += valor
    }
    method puedeUsar(unAparato){
        return unAparato.puedeSerUsadoPor(self)
    }
    method usar(unAparato){
        if(! self.puedeUsar(unAparato)){
            self.error("El paciene no puede usar este aparato")
        }
        unAparato.esUsadoPor(self)
    }

}

class Magneto{
   method esUsadoPor(unPaciente){
      unPaciente.disminuirDolor(unPaciente.dolor()*0.1)
   }
    method puedeSerUsadoPor(unPaciente){
       return true 
    }
}
class Bicicleta{
   method esUsadoPor(unPaciente){
    unPaciente.disminuirDolor(4)
    unPaciente.aumentarFortaleza(3)
   }
    method puedeSerUsadoPor(unPaciente){
       return unPaciente.edad() > 8
    }
}
class Minitramp{
    method esUsadoPor(unPaciente){
    unPaciente.aumentarFortaleza(unPaciente.edad()*0.1)
   }
   method puedeSerUsadoPor(unPaciente){
       return unPaciente.dolor() < 20
    }
}
