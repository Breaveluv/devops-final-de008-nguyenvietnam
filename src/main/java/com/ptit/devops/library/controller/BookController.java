package com.ptit.devops.library.controller;

import com.ptit.devops.library.entity.Book;
import com.ptit.devops.library.repository.BookRepository;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class BookController {

    private final BookRepository repository;

    public BookController(BookRepository repository) {
        this.repository = repository;
    }

    /** GET /api/books - danh sách sách trong thư viện */
    @GetMapping("/books")
    public List<Book> findAll() {
        return repository.findAll(Sort.by("id"));
    }
}
