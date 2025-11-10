<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Booking Confirmation</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(120deg, #1f1c2c, #928DAB);
            color: #fff;
            text-align: center;
            padding-top: 50px;
        }

        .ticket {
            width: 500px;
            margin: auto;
            background: #fff;
            color: #000;
            padding: 25px;
            border-radius: 15px;
            position: relative;
            box-shadow: 0 6px 20px rgba(0,0,0,0.4);
        }

        .ticket:before, .ticket:after {
            content: "";
            width: 30px;
            height: 30px;
            background: #928DAB;
            position: absolute;
            border-radius: 50%;
        }

        .ticket:before {
            top: -15px;
            left: 220px;
        }

        .ticket:after {
            bottom: -15px;
            left: 220px;
        }

        h2 {
            margin-bottom: 10px;
            color: #111;
        }

        .details {
            text-align: left;
            margin: 20px 0;
            font-size: 18px;
            line-height: 30px;
        }

        .btn-back {
            background: #ffcc00;
            padding: 10px 18px;
            text-decoration: none;
            font-weight: bold;
            color: #000;
            border-radius: 8px;
            display: inline-block;
            margin-top: 15px;
            transition: 0.3s;
        }

        .btn-back:hover {
            background: #000;
            color: #fff;
        }
    </style>
</head>
<body>

<%
    String name = request.getParameter("name");
    String movie = request.getParameter("movie");
    String seats = request.getParameter("seats");
%>

    <h1>✅ Booking Confirmed!</h1>

    <div class="ticket">
        <h2>🎬 <%= movie %></h2>
        <div class="details">
            <p><strong>👤 Name:</strong> <%= name %></p>
            <p><strong>🪑 Seats:</strong> <%= seats %></p>
            <p><strong>🎟️ Booking ID:</strong> BK<%= (int)(Math.random()*9000) + 1000 %></p>
        </div>
    </div>

    <a class="btn-back" href="movies.jsp">Back to Movies</a>

</body>
</html>
