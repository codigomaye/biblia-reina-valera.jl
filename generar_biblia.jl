using JSON

struct LibroBiblico
	nombre::String
	contenido::Vector{Vector{String}}
end

# 1. Listar todos los ficheros de biblia
# 2. Iterar cada fichero, y anadir un nuevo LibroBiblico
#		-> nombre == nombre del ficero
# 		-> contenido == contenido del fichero parseado

function crear_biblia()
	biblia_dir = "./biblia"
	libros = readdir(biblia_dir)
	result = Vector{LibroBiblico}()
	nombre_libro = " "
	contenido_libro_raw = " "
	contenido_libro = Vector{Vector{String}}()

	function leer_libro(libro)
		read(libro, String)
	end
	
	for x in libros
	
		if x == "_index.json"
			continue
		end
		
		nombre_libro = SubString(x, 1, sizeof(x) - 5)
		println(String(nombre_libro))
		contenido_libro = JSON.parse(leer_libro(biblia_dir * "/" * x))

		println(contenido_libro_raw)
		libro = LibroBiblico(String(nombre_libro), contenido_libro) 
		push!(result, libro)
	end

	return result
end


function buscar_libro(libro)
	for x = biblia
		if x.nombre == libro
			return x.contenido
		end
	end
end

b(l) = buscar_libro(l)

function leer(versiculos)
	println("\n")
	for v in versiculos
		println("> "  * v * "\n")
	end
end

l(v)= leer(v)

biblia = Vector{LibroBiblico}(crear_biblia())

