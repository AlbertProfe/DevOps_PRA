package io.company.library;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

@RestController
//@CrossOrigin(origins = "http://localhost:5173") // Adjust the origin as needed
//@CrossOrigin(origins = "http://localhost:[*]")
//@CrossOrigin(origins = "*")  // Permite todas las conexiones en desarrollo
@CrossOrigin(
        origins = "http://localhost:5173",
        allowCredentials = "true"
)
@RequestMapping("api")
public class LibraryRestController {

    @Autowired
    BookRepository bookRepository;

    // CRUD: Read (with pagination)
    @GetMapping("books")
    public Page<Book> bookPageable(Pageable pageable) {
        return bookRepository.findAll(pageable);
    }

    // CRUD: Create
    @PostMapping("books")
    public ResponseEntity<Book> createBook(@RequestBody Book book) {
        Book savedBook = bookRepository.save(book);
        return new ResponseEntity<>(savedBook, HttpStatus.CREATED);
    }

    // CRUD: Read (single book)
    @GetMapping("books/{id}")
    public ResponseEntity<Book> getBookById(@PathVariable Long id) {
        return bookRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // CRUD: Update
    @PutMapping("books/{id}")
    public ResponseEntity<Book> updateBook(@PathVariable Long id, @RequestBody Book bookDetails) {
        return bookRepository.findById(id)
                .map(book -> {
                    book.setTitle(bookDetails.getTitle());
                    book.setAuthor(bookDetails.getAuthor());
                    book.setPages(bookDetails.getPages());
                    book.setPublishedYear(bookDetails.getPublishedYear());
                    book.setIsbn(bookDetails.getIsbn());
                    Book updatedBook = bookRepository.save(book);
                    return ResponseEntity.ok(updatedBook);
                })
                .orElse(ResponseEntity.notFound().build());
    }

    // CRUD: Delete
    @DeleteMapping("books/{id}")
    public ResponseEntity<Void> deleteBook(@PathVariable Long id) {
        if (bookRepository.existsById(id)) {
            bookRepository.deleteById(id);
            return ResponseEntity.noContent().build();
        }
        return ResponseEntity.notFound().build();
    }
}