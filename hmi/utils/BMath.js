
function maxOfArray(numArray) {
    return Math.max.apply(null, numArray);
}


function ms2kmh(value, fixed, leadZero) {
    var kmh = (value*3600/1000)

    kmh = (typeof(fixed) === "number") ? kmh.toFixed(fixed) : kmh.toFixed(1)

    if (leadZero) {
        if (kmh < 10) {
            return "0" + kmh
        } else {
            return kmh.toString()
        }
    } else {
        return kmh.toString()
    }
}
