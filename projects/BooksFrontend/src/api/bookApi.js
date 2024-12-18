import axios from 'axios';

const API_URL = 'http://localhost:8080/api/books';

export const getBooks = (page = 0, size = 10) => {
  return axios.get(`${API_URL}?page=${page}&size=${size}`);
};

export const getBook = (id) => {
  return axios.get(`${API_URL}/${id}`);
};

export const createBook = (book) => {
  return axios.post(API_URL, book);
};

export const updateBook = (id, book) => {
  return axios.put(`${API_URL}/${id}`, book);
};

export const deleteBook = (id) => {
  return axios.delete(`${API_URL}/${id}`);
};