// eslint-disable-next-line no-unused-vars
import React from "react";
import BookList from "./components/BookList";
import BookForm from "./components/BookForm";

function App() {
  return (
    <div>
      <h1>Book Management System</h1>
      <BookForm onBookAdded={() => {}} />
      <BookList />
    </div>
  );
}

export default App;
