// eslint-disable-next-line no-unused-vars
import React, { useState } from "react";
import { createBook } from "../api/bookApi";
import { Box, TextField, Button } from "@mui/material";

// eslint-disable-next-line react/prop-types
const BookForm = ({ onBookAdded }) => {
  const [book, setBook] = useState({
    title: "",
    author: "",
    pages: 0,
    publishedYear: 0,
    isbn: "",
  });

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await createBook(book);
      onBookAdded();
      setBook({ title: "", author: "", pages: 0, publishedYear: 0, isbn: "" });
    } catch (error) {
      console.error("Error creating book:", error);
    }
  };

  const handleChange = (e) => {
    setBook({ ...book, [e.target.name]: e.target.value });
  };

  return (
    <Box sx={{ padding: 2, margin: 2 }}>
      <form onSubmit={handleSubmit}>
        <TextField
          label="Title"
          name="title"
          value={book.title}
          onChange={handleChange}
          required
          fullWidth
          margin="normal"
        />
        <TextField
          label="Author"
          name="author"
          value={book.author}
          onChange={handleChange}
          required
          fullWidth
          margin="normal"
        />
        <TextField
          label="Pages"
          name="pages"
          value={book.pages}
          onChange={handleChange}
          required
          fullWidth
          margin="normal"
          type="number"
        />
        <TextField
          label="Published Year"
          name="publishedYear"
          value={book.publishedYear}
          onChange={handleChange}
          required
          fullWidth
          margin="normal"
          type="number"
        />
        <TextField
          label="ISBN"
          name="isbn"
          value={book.isbn}
          onChange={handleChange}
          required
          fullWidth
          margin="normal"
        />
        <Button variant="contained" type="submit" fullWidth margin="normal">
          Add Book
        </Button>
      </form>
    </Box>
  );
};

export default BookForm;