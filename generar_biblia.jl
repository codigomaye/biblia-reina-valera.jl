using JSON

"""
	createbible(bible_dir)

Reads all JSON Bible Books listed in directory `bible_dir` and returns a Dict 
whose key is a Bible Book name, and it's value is an Array of the corresponding 
Chapters and verses of the Bible Book.  
"""
function createbible(bible_dir::String)

	if bible_dir[end] != "/"
		bible_dir = bible_dir * "/"
	end
	
	bible = Dict{String, Vector{Any}}()
	bible_book_name = " "
	bible_book_verses = []

	bible_books_list = readdir(bible_dir)

	for bible_book in bible_books_list
	
		# removes the 5 last characters of the json part of the string
		bible_book_name = bible_book[1:end-5]
		
		bible_book_verses = JSON.parse(read(bible_dir * bible_book, String))

		bible[bible_book_name] = bible_book_verses
	end

	return bible
end

function searchverses(bible::Dict, bookname::String, chapter::Integer, 
						verse_start::Int, verse_end::Int=0)
	if verse_end == 0
		return bible[bookname][chapter][verse_start:verse_start]
	elseif  0 < verse_end > verse_start
		return bible[bookname][chapter][verse_start:verse_end]
	end
end

function readverses(verses_list)
	println("\n");
	for verse in verses_list
		println(verse * "\n");
	end
end

function search_and_read_verses(bible::Dict, bookname::String, chapter::Integer, 
						verse_start::Int, verse_end::Int=0)
						
	verses_list = searchverses(bible, bookname, chapter, 
				 verse_start, verse_end)

	readverses(verses_list)

	return nothing

end
