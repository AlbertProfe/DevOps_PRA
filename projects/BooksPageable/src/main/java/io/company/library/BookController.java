package io.company.library;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class BookController {

    @Autowired
    BookService bookService;


    @GetMapping("/page/{pageNo}")
    public String booksPaginated(@PathVariable(value = "pageNo") int pageNo, Model model) {

        int pageSize = 10;

        Page<Book> page = bookService.findPaginated(pageNo, pageSize);
        List<Book> listBooks = page.getContent();

        model.addAttribute("currentPage", pageNo);
        model.addAttribute("totalPages", page.getTotalPages());
        model.addAttribute("totalItems", page.getTotalElements());
        model.addAttribute("listBooks", listBooks);

        return "books";
    }
}