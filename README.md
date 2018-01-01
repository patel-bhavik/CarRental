Car Rental
================

Link: https://car-rental-company.herokuapp.com

Admin Credentials: email: admin@gmail.com password: admin123<br>
SuperAdmin Credentials: email: superadmin@gmail.com password: supadmin123  
There are 3 types of Users - Customers, Admins and Superadmins and their functionalities are described as follows  

### Customer can -
* Login/Logout and Signup to the application
* When Logged in, customer can -
  * View their own profile
  * Edit their own profile
  * View List of cars, their details and their availablity.
  * Can search cars on basis of his/her preference.
  * Can reserve an available car.
  * Can checkout the car that had been reserved.
  * Can return the car before/at the specified time.
  * View the current reservation that he/she has.
  * View his/her reservation History.
  * Suggest new cars to the admin.
  * Can subscribe to notification for the availablity of a car.
  * can checkout the car he/she rented only before 10 minutes of his/her reservation start time.
    
### Admin can - 
* Login/Logout 
* When Logged in, admin can -
  * View their own profile
  * Edit their own profile
  * Create new Admin
  * View profile of other Admins
  * Delete other Admins
  * View List of cars, their details and their availablity.
  * Add a new Car, Edit and Delete already existing cars
  * View the reservation history for a particular Car
  * Can view the suggestions given by the customers and make a decision whether to accept or reject
  * View all the current reservations in the system.
  * View profile of all the customers.
  * Edit and Delete customers.
  * Can reserve, checkout or return car on behalf of customer.
  * Edit their reservation
  * View their reservation history.
    
### Superadmin can -
* Login/Logout 
* When Logged in, admin can -
  * perform all fuctions that an Admin can
  * can create new superadmin
  * can view list of other superadmins
    
### Some Conditions and Constraints for the application
* Our tests are located in **spec** folder of our project directory.
* The application uses email to notify the customers so they must use valid email id for registering.
* When the customer doesn't return the car on the specified reservation end time, the car automatically becomes available and the transaction is closed with the reservation being removed from current one and added to the history. Also, the customer is notified through email.
* To simplify the rental charge calculations, the reservation time specified is used to calculate it rather than the actual checkout and return time.
* Admin cannot delete a car with pending reservations.
* If admin deletes a car, which was once checked out by a user, car gets deleted from the system but it still appears in the checkout history of the user.
* Similarly admin cannot delete a customer with pending reservations. Also he cannot delete a customer who has a reservation history as deleting him/her will affect the reservation history of many cars in the system.
* For the customer suggestions, if a manufacturer-model combination has already been suggested, another customer cannot suggest the same combination. Instead he gets a message telling him that such a suggestion has already been made. 
* For the customer suggestions, if an admin approves the suggestion, he can edit it before adding the car to the system.
* For the customer subscription, a customer cannot subscribe to a car he/she has already reserved/checked out.
* The reservation time have been set by active job. So changing system time might not work. You have to actually wait for that much time.
* For an admin to reserve a car for customer go to customers section in admin and select that particular customer.
* Heroku sleep constraint - Some request to server has to be made at least every twenty to thirty minutes to prevent heroku from sleeping due to long-time idling. Only following 2 features use schedulers and affected by this constraint.
    * If a car is not  30 minutes after the pickup time, car will be made available again and reservation will be cancelled.
    * If the car is not returned in time, car will be made available and notification email is sent to user to return asap.
