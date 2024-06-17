const  idRegexp = /^[1-9]+$/;
const rolenameDescriptionRegexp = /^[a-zA-Z]{4}[a-zA-Z_ ]*$/;
const isActiveRegexp = /^[01]$/;
const isValidName = /^[a-zA-Z]{2}[a-zA-Z_ ]*$/;
const userNameRegexp = /^[a-zA-Z]{2}[a-zA-Z ]*$/;
const emailRegexp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+(\.[a-zA-Z]{2,})$/;
const phoneNumRegexp = /^\d{9}$/;
const passwordRegexp = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*])[A-Za-z\d@#$%^&*]{8,}$/;

const isRegexpValid = (regexp,value) => {
    if (!/^\S$/.test(value) || !regexp.test(value) ) {
        return false;
    }
    return true;
  }

module.exports = {idRegexp, rolenameDescriptionRegexp,
  isActiveRegexp, isValidName,emailRegexp,isRegexpValid,userNameRegexp,phoneNumRegexp,passwordRegexp
};