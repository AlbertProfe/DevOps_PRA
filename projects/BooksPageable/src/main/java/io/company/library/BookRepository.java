package io.company.library;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BookRepository extends PagingAndSortingRepository<Book, Long> {
    Book save(Book book);

    Optional<Book> findById(Long id);

    void deleteById(Long id);

    boolean existsById(Long id);
    // No need to declare save method, it's already provided by PagingAndSortingRepository
}