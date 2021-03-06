const functions = require('firebase-functions');
const express = require('express')
const app = express()

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Allow-Request-Method');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});

app.get("/sales", (request, response) => {
  response.json({
    storeOrders: [
      { store: "Chia Fruver", amount: "154", value: "20042540" },
      { store: "Bog sta fe", amount: "106", value: "14683970" },
      { store: "Bog Cdad Jardin", amount: "100", value: "14326670" },
      { store: "Bog Suba Vll eliza", amount: "70", value: "10377460" },
      { store: "Med volador", amount: "69", value: "9179410" },
      { store: "Med Tarapaca", amount: "68", value: "8689390" },
      { store: "Bog quintaparedes", amount: "59", value: "7214370" },
      { store: "Bog barranxas", amount: "36", value: "5814170" },
      { store: "Med el diamante", amount: "34", value: "5016740" },
      { store: "Bog suba salitre", amount: "33", value: "4228320" },
      { store: "Bog la uribe", amount: "28", value: "2944420" },
      { store: "Bog san javier", amount: "19", value: "2741700" },
      { store: "Bog country", amount: "18", value: "2500430" },
      { store: "Bog floresta", amount: "14", value: "17928" },
    ],
    dayOrders: [
      { day: "2020-04-10", amount: "7", value: "399560" },
      { day: "2020-04-11", amount: "21", value: "2338430" },
      { day: "2020-04-12", amount: "42", value: "5623470" },
      { day: "2020-04-13", amount: "25", value: "3729670" },
      { day: "2020-04-14", amount: "18", value: "2180310" },
      { day: "2020-04-15", amount: "18", value: "3020260" },
      { day: "2020-04-16", amount: "13", value: "1990000" },
      { day: "2020-04-17", amount: "46", value: "7003620" },
      { day: "2020-04-18", amount: "294", value: "38556130" },
      { day: "2020-04-19", amount: "113", value: "15531570" },
      { day: "2020-04-20", amount: "227", value: "32647330" },
    ],
    strips: [
      { type: "Mañana", amount: "232", value: "31203240" },
      { type: "Tarde", amount: "595", value: "81817110" },
    ],
    ticketDay: [
      { day: "2020-04-10", value: "48294" },
      { day: "2020-04-11", value: "101076" },
      { day: "2020-04-12", value: "114728" },
      { day: "2020-04-13", value: "130059" },
      { day: "2020-04-14", value: "100341" },
      { day: "2020-04-15", value: "161807" },
      { day: "2020-04-16", value: "153077" },
      { day: "2020-04-17", value: "152253" },
      { day: "2020-04-18", value: "131143" },
      { day: "2020-04-19", value: "137488" },
      { day: "2020-04-20", value: "143243" },
      { day: "2020-04-21", value: "143054" },
    ],
    ticketStore: [
      { store: "D1 - Cota Terracota", value: "80180" },
      { store: "D1 - Medellin San Javier", value: "105251" },
      { store: "D1 - MED Volador 2", value: "109950" },
      { store: "D1 - Chia Frubver", value: "125469" },
      { store: "D1 - Bogota Suba Salite", value: "126302" },
      { store: "D1 - Medellin El diamante", value: "132139" },
      { store: "D1 - Bogota Estacion Sabana", value: "134810" },
      { store: "D1 - Bogota Santa Fe", value: "137296" },
      { store: "D1 - Bogota La Uribe", value: "143591" },
      { store: "D1 - Bogota Ciudad Jardin del Norte", value: "143591" },
      { store: "D1 - Bogota Barrancas", value: "145471" },
      { store: "D1 - Bogota Country", value: "149433" },
      { store: "D1 - Chia Variante", value: "168372" },
      { store: "D1 - Bogota Quintaparedes", value: "181869" },
      { store: "D1 - Cajica San Jeronimo", value: "349360" },
    ],
    products: [
      { product: "lacteos", amount: "4847", value: "9000000" },
      {
        product: "Carne Pollo Pescado Y Cerdo",
        amount: "1779",
        value: "8168220",
      },
      { product: "Carnes frías", amount: "1622", value: "5463120" },
      { product: "Higiene Personal", amount: "1489", value: "5301850" },
      { product: "Pasabocas", amount: "1449", value: "5013360" },
      { product: "Galletería y dulces", amount: "1363", value: "4699740" },
      { product: "Comidas Listas", amount: "1321", value: "4197600" },
      { product: "Granos Y Panela", amount: "1211", value: "4143060" },
      { product: "Enlatados y Envasados", amount: "1161", value: "3846990" },
      { product: "Panaderia y Reposteria", amount: "1136", value: "3766292" },
      { product: "Frutas Y verduras", amount: "1080", value: "3756550" },
      { product: "Bebidas Alcoholicas", amount: "1074", value: "3581470" },
      { product: "Margarinas y Aceites", amount: "985", value: "3251670" },
      { product: "Cuidado ropa", amount: "956", value: "3196390" },
      {
        product: "Limpieza Superficies y Cocina",
        amount: "888",
        value: "3176390",
      },
      { product: "Bebidas liquidas", amount: "847", value: "2970720" },
      {
        product: "Cereales Harinas Y Premezclas",
        amount: "843",
        value: "2909630",
      },
      { product: "Desechables", amount: "789", value: "2734500" },
      { product: "Huevos", amount: "642", value: "2501050" },
      { product: "Salsas y Aderezos", amount: "612", value: "2131130" },
      { product: "Aseo General", amount: "558", value: "2014600" },
      { product: "Bebidas en Polvo", amount: "538", value: "1754230" },
      { product: "Pastas", amount: "496", value: "1636490" },
      { product: "Mascotas", amount: "496", value: "1402470" },
      { product: "Medicamentos", amount: "444", value: "1401570" },
      { product: "Utensilios", amount: "365", value: "1047210" },
      { product: "Arepas", amount: "263", value: "1033470" },
      { product: "Condimentos", amount: "256", value: "939100" },
      { product: "Bebes", amount: "200", value: "929500" },
      { product: "Belleza", amount: "150", value: "474270" },
    ],
    deliveriesAfterHours: [
      { day: "2020-04-19", value: "1" },
      { day: "2020-04-20", value: "1" },
      { day: "2020-04-21", value: "6" },
      { day: "2020-04-22", value: "1" },
    ],
  });
});
app.get("/login", (request, response) => {
  response.json({
    token: "EL_PUTISIMO_TOKEN",
    establishment: {
      id: 001,
      name: "D1 Villa Elisa",
      colorss: 
        {
          primary: "#db071e",
          secondary: "#006db5",
        },
      
    },

    user: {
      name: "YSUS",
    },
  });
});
exports.app = functions.https.onRequest(app)
// app.listen("8010", () => {
//   console.log("Listening on port 8010");
// });


