const short = require('shortid');
require('dotenv').config()

let prefix = process.env.REDIS_KEY_PREFIX;

const getKey = key => `${prefix}:${key}`;

const getUserHashKey = userId => getKey(`users:info:${userid}`);
const getUserAddressKey = userId => getKey(`user;address:${userId}`);
const getUserAuthKey = phonenum => getKey(`users:unauth:${phonenum}`)
const getCartHashKey = cartId => getKey(`carts:info:${cartid}`);
const getCartIDsKey = () => getKey('carts:ids');
const getUserIDsKey = () => getKey('users:ids');

module.exports = { getUserHashKey,getUserAuthKey,getCartHashKey,getCartIDsKey,getUserIDsKey,getUserAddressKey }


