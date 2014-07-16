<%@ page import="database.Itinerary" %>
<%@ page import="database.Budget" %>
<%@ page import="database.Expenditure" %>
<%@ page import="database.DataManager" %>

<%@ page import="java.util.List" %>

<%
    Itinerary currentItinerary = (Itinerary) session.getAttribute("activeItinerary");
    int budgetID = currentItinerary.getBudgetID();
    Budget budget = DataManager.fetchBudget(budgetID);
    List<Expenditure> expenditures = budget.getExpenditures();
%>

<% if (budget.getID() == null || budget.getID() == 0) { %>
<button onclick="document.getElementById('createBudget-div').style.display='block';">Create Budget</button>
<div id="createBudget-div" style="display:none">
    <form action="/CS2340Servlet/budget" method="POST">
        <label>Enter budget for this itinerary: $</label>
        <input type="text" name="originalBudget" pattern="^\d*(\.\d{2}$)?" size="4"
               title="CDA Currency Format - no dollar sign and no comma(s) - cents (.##) are optional" />
        <input type="hidden" name="itineraryID" value=<%=currentItinerary.getID()%> />
        <input type="submit" name="createBudgetButton" value="Submit" />
    </form>
</div>
<% } else { %>
<button id="addExpenditureButton">Add expenditure</button>
<div>
    <form id="expenseForm" action="/CS2340Servlet/budget" method="POST">
        <input type="hidden" name="budgetID" value=<%=budget.getID()%> />
        <input type="hidden" name="currentBudget" value=<%=budget.getCurrentBudget()%> />
        <input type="submit" name="saveExpenseBtn" value="Submit" style="display:none" />
    </form>
</div>

<div id="budgetOverview-Div">
    <p>Original Budget: $<%=budget.getOriginalBudget()%></p>
    <p>Current Budget: $<%=budget.getCurrentBudget()%></p>
    <p>Budget Last Updated On: <%=budget.getLastUpdated()%></p>
    <table>
        <tr>
            <th>Expense Description</th>
            <th>Expense Amount</th>
            <th>Expense Date</th>
        </tr>
        <% for (Expenditure expense : expenditures) { %>
        <tr>
            <td><%=expense.getDescription()%></td>
            <td>$<%=expense.getAmountSpent()%></td>
            <td><%=expense.getExpenseDate()%></td>
        </tr>
        <% } %>
    </table>
</div>
<% } %>

<script>
    var expenseFormStr = '<div>' +
            '<label>Description of expense:</label>' +
            '<textarea name="expenseDescription"></textarea></br>' +
            '<label>Amount Spent:</label>' +
            '<input type="text" name="amountSpent" />' +
            '<label>Date incurred:</label>' +
            '<input type="text" name="expenseDate" id="_datetimepicker" />' +
            '<hr/>' +
            '</div>'
    $('#addExpenditureButton').on("click", function(){
        $('#expenseForm').prepend(expenseFormStr);
        $('input[name=saveExpenseBtn]').show();
        $('#_datetimepicker').datetimepicker();
    });
</script>
