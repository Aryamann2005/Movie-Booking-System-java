<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movies List</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(120deg, #1f1c2c, #928DAB);
            color: #fff;
            text-align: center;
            padding-top: 50px;
        }

        .movies-container {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            margin-top: 40px;
        }

        .movie-card {
            background: rgba(255, 255, 255, 0.1);
            width: 260px;
            padding: 20px;
            text-align: center;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            transition: 0.3s ease-in-out;
        }

        .movie-card:hover {
            transform: translateY(-8px);
            background: rgba(255, 255, 255, 0.2);
        }

        .movie-card h2 {
            margin-bottom: 10px;
            font-size: 22px;
            color: #ffdd57;
        }

        .movie-card p {
            margin: 5px 0 12px;
        }

        .btn-book {
            padding: 10px 18px;
            background: #ffcc00;
            color: #000;
            font-weight: bold;
            border-radius: 5px;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-book:hover {
            background: #fff;
            color: #000;
        }
    </style>
</head>

<body>
    <h1>🍿 Now Showing</h1>

    <div class="movies-container">
        <div class="movie-card">
            <h2>Inception</h2>
            <p>Genre: Sci-Fi</p>
           <a class="btn-book" href="booking.jsp?movie=Inception">Book Now</a>
        </div>

        <div class="movie-card">
            <h2>Avengers: Endgame</h2>
            <p>Genre: Action</p>
            <a class="btn-book" href="booking.jsp?movie=Avengers Endgame">Book Now</a>
        </div>

        <div class="movie-card">
            <h2>Interstellar</h2>
            <p>Genre: Drama</p>
            <a class="btn-book" href="booking.jsp?movie=Interstellar">Book Now</a>
        </div>
    </div>
</body>
</html>
