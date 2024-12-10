// eslint-disable-next-line no-unused-vars
import React, { useState, useEffect } from "react";
import { getBooks, deleteBook } from "../api/bookApi";
import {
  Box,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  Button,
  Pagination,
} from "@mui/material";

const BookList = () => {
  const [books, setBooks] = useState([]);
  const [currentPage, setCurrentPage] = useState(0);
  const [totalPages, setTotalPages] = useState(0);
  const [totalElements, setTotalElements] = useState(0);

  useEffect(() => {
    fetchBooks();
  }, [currentPage]);

  const fetchBooks = async () => {
    try {
      const response = await getBooks(currentPage);
      setBooks(response.data.content);
      setTotalPages(response.data.totalPages);
      setTotalElements(response.data.totalElements);
    } catch (error) {
      console.error("Error fetching books:", error);
    }
  };

  const handleDelete = async (id) => {
    try {
      await deleteBook(id);
      fetchBooks();
    } catch (error) {
      console.error("Error deleting book:", error);
    }
  };

  const handlePageChange = (event, value) => {
    setCurrentPage(value - 1);
  };

  return (
    <Box sx={{ padding: 2, margin: 2 }}>
      <h2>Book List</h2>
      <Table sx={{ minWidth: 650 }}>
        <TableHead>
          <TableRow>
            <TableCell>Book ID</TableCell>
            <TableCell align="right">Title</TableCell>
            <TableCell align="right">Author</TableCell>
            <TableCell align="right">Pages</TableCell>
            <TableCell align="right">Published Year</TableCell>
            <TableCell align="right">ISBN</TableCell>
            <TableCell align="right">Actions</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {books.map((book) => (
            <TableRow key={book.bookId}>
              <TableCell component="th" scope="row">
                {book.bookId}
              </TableCell>
              <TableCell align="right">{book.title}</TableCell>
              <TableCell align="right">{book.author}</TableCell>
              <TableCell align="right">{book.pages}</TableCell>
              <TableCell align="right">{book.publishedYear}</TableCell>
              <TableCell align="right">{book.isbn}</TableCell>
              <TableCell align="right">
                <Button
                  variant="contained"
                  color="error"
                  onClick={() => handleDelete(book.bookId)}
                >
                  Delete
                </Button>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
      <Pagination
        count={totalPages}
        page={currentPage + 1}
        onChange={handlePageChange}
      />
      <div>Total Rows: {totalElements}</div>
    </Box>
  );
};

export default BookList;