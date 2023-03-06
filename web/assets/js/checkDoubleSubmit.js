let flag = false;
let checkDoubleSubmit = () => {
    if(flag) {
        return flag;
    } else {
        flag = true;
        return false;
    }
}

let resetFlag = () => {
    flag = false;
}