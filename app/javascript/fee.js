function calc (){
  const price = document.getElementById("item-price");
  const feePrice = document.getElementById("add-tax-price");
  const profitPrice = document.getElementById("profit");
  if (price.value != "") {
    feePrice.innerHTML = Math.round(price.value / 10);
    profitPrice.innerHTML = price.value - Math.round(price.value / 10);
  }else{
    feePrice.innerHTML = 0;
    profitPrice.innerHTML = 0;
  }

  price.addEventListener("keyup", () => {
    const originalPrice = price.value;
    const fee = Math.round(originalPrice / 10);
    const profit = originalPrice - fee;
    feePrice.innerHTML = fee;
    profitPrice.innerHTML = profit;
  })
}

if (document.URL.match( /items/ )) {
window.addEventListener('load', calc);
}