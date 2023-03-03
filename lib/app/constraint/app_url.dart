//--> only for your local server
// const baseUrl = "http://localhost:5000/";

// --> only for your android (localhost --> 10.0.2.2)
// const baseUrl = "http://10.0.2.2:5000/";

// --> only for your android real device
// const baseUrl = "http://192.168.137.249:5000/";

//My Home
const baseUrl = "http://192.168.0.106:5000/";

// For Testing
// const baseUrl = "http://localhost:5000/";

// other urls
const loginUrl = "user/login";
const registerUrl = "user/register";
const foodUrl = "food";

const foodCategoryUrl = "food_category";

const cartUrl = "cart";
const orderUrl = "order";
// const cartDeleteUrl = "cart/delete/:id";
// const foodCategoryUrl = "food_category/get";

const userUrl = "user";
const updateProfileAllUrl = "user/update/profile-all";
const updateProfileDataUrl = "user/update/profile-data";
const changePasswordUrl = "user/change-password";

// for token
String? tokenConstant = "";

String? getSelectedPaymentMethod = "Cash On Delivery";
