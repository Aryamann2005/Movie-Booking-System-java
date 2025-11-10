<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.moviebooking.utils.SeatXMLReader" %>
<%
    String movieName = request.getParameter("movie");
    Map<String, Map<String, Map<String, Map<String, String>>>> seatData = SeatXMLReader.getSeatData();

    if (movieName == null || seatData == null || !seatData.containsKey(movieName)) {
%>
        <h1 style="color:red; text-align:center;">❌ Seat data not found for this movie!</h1>
        <p style="text-align:center;">
            <a href="movies.jsp">Back to Movies</a>
        </p>
<%
        return;
    }

    Map<String, Map<String, Map<String, String>>> movieShows = seatData.get(movieName);
    String selectedShow = request.getParameter("show");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Seats - <%= movieName %></title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: white;
            text-align: center;
        }
        h1 { margin-top: 20px; }
        .showtime-btn {
            padding: 10px 20px;
            margin: 5px;
            background: #0984e3;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }
        .showtime-btn:hover { background: #74b9ff; }

        .seat-container { display: flex; justify-content: center; margin-top: 20px; flex-wrap: wrap; }
        .seat-type {
            width: 80%; margin: 15px auto; background: #2d3436; padding: 10px;
            border-radius: 8px; box-shadow: 0 0 8px rgba(255,255,255,0.2);
        }
        .seat-row { display: flex; justify-content: center; margin: 5px 0; }
        .seat {
            width: 28px; height: 28px; margin: 3px;
            border-radius: 5px; display: flex; justify-content: center; align-items: center;
            font-size: 11px; cursor: pointer;
        }
        .available { background: #4CAF50; color: white; }
        .booked { background: #E74C3C; color: white; cursor: not-allowed; }
        .selected { background: #ff9800 !important; color: white; }

        .payment-section {
            margin-top: 30px;
            display: none;
            background: #1e272e;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
            margin-left: auto;
            margin-right: auto;
            box-shadow: 0 0 10px rgba(255,255,255,0.2);
        }
        input, select, button {
            padding: 10px;
            margin: 8px;
            border-radius: 5px;
            border: none;
            width: 80%;
        }
        button.pay-btn {
            background-color: #00b894;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }
        button.pay-btn:hover { background-color: #55efc4; }

        .total-display {
            font-size: 18px;
            margin-top: 10px;
            color: #ffdd57;
        }
    </style>
    <script>
        let totalAmount = 0;

        function selectSeat(seatDiv) {
            if (seatDiv.classList.contains('booked')) return;

            const seatType = seatDiv.getAttribute('data-type');
            const price = seatType === 'VIP' ? 400 : 250;

            if (seatDiv.classList.contains('selected')) {
                seatDiv.classList.remove('selected');
                totalAmount -= price;
            } else {
                seatDiv.classList.add('selected');
                totalAmount += price;
            }

            document.getElementById('paymentSection').style.display = totalAmount > 0 ? 'block' : 'none';
            document.getElementById('totalAmount').innerText = "₹" + totalAmount;
            document.getElementById('amountInput').value = totalAmount;
        }
    </script>
</head>
<body>

<h1>🎟 Book Seats for <%= movieName %></h1>

<!-- 🎬 Dynamic Trailer -->
<%
    String trailerUrl = "";
    String normalizedMovie = movieName.toLowerCase().trim();
    if (normalizedMovie.contains("inception")) {
        trailerUrl = "https://www.youtube.com/embed/YoHD9XEInc0";
    } else if (normalizedMovie.contains("avengers")) {
        trailerUrl = "https://www.youtube.com/embed/TcMBFSGVi1c";
    } else if (normalizedMovie.contains("interstellar")) {
        trailerUrl = "https://www.youtube.com/embed/zSWdZVtXT7E";
    }
%>

<div style="display:flex; justify-content:center; align-items:center; margin:20px;">
    <iframe width="560" height="315" src="<%= trailerUrl %>" frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen></iframe>
</div>

<!-- Showtime selection -->
<% if (selectedShow == null) { %>
    <h2>Select Show Time</h2>
    <form method="get">
        <input type="hidden" name="movie" value="<%= movieName %>">
        <% for (String show : movieShows.keySet()) { %>
            <button class="showtime-btn" name="show" value="<%= show %>"><%= show %></button>
        <% } %>
    </form>
<% } else { %>

    <h2>Show Time: <%= selectedShow %></h2>
    <form action="confirm.jsp" method="post">
        <input type="hidden" name="movie" value="<%= movieName %>">
        <input type="hidden" name="show" value="<%= selectedShow %>">

        <% Map<String, Map<String, String>> seatTypes = movieShows.get(selectedShow);
            for (String type : seatTypes.keySet()) { %>

            <div class="seat-type">
                <h3><%= type %> Seats (<%= type.equals("VIP") ? "₹400" : "₹250" %> each)</h3>
                <% Map<String, String> seats = seatTypes.get(type);
                    char currentRow = 'X';
                    for (String seatId : seats.keySet()) {
                        char row = seatId.charAt(0);
                        if (row != currentRow) {
                            if (currentRow != 'X') { %></div><% }
                            currentRow = row;
                %>
                        <div class="seat-row">
                <% }
                        String status = seats.get(seatId);
                %>
                        <div class="seat <%= status %>" data-type="<%= type %>" onclick="selectSeat(this)">
                            <%= seatId %>
                        </div>
                <% } %>
                </div>
            </div>
        <% } %>
    </form>

    <!-- 💳 Payment Section -->
    <div id="paymentSection" class="payment-section">
        <h2>Payment Details</h2>
        <div class="total-display">Total: <span id="totalAmount">₹0</span></div>
        <form action="confirm.jsp" method="post">
            <input type="hidden" id="amountInput" name="amount" value="0">
            <select required>
                <option value="">Select Payment Method</option>
                <option value="gpay">Google Pay</option>
                <option value="paytm">Paytm</option>
                <option value="cod">Cash on Delivery</option>
            </select>
            <input type="text" placeholder="Name / UPI ID" required>
            <button type="submit" class="pay-btn">Confirm & Pay</button>
        </form>
    </div>
<% } %>

</body>
</html>
