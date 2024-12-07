package io.company.library;

import com.github.javafaker.Faker;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import java.util.Scanner;

    @Component
    public class ApplicationCommandRunner implements CommandLineRunner {

        protected final Log logger = LogFactory.getLog(getClass());

        @Autowired
        BookRepository bookRepository;

        @Override
        public void run(String... args) throws Exception {
            createFakerBooks();
        }



        public void createFakerBooks(){
            logger.info("Welcome to the createFakerBooks");

            Faker faker = new Faker();

            for (int i = 0; i < 100; i++){
                bookRepository.save ( new Book(faker.book().title(),
                        faker.book().author(), faker.number().numberBetween(15,1500),
                        faker.number().numberBetween(1800,2000),  String.valueOf(faker.number().randomNumber(10,true))));
            }

            logger.info("finishing createFakerBooks ...");
        }


    }

