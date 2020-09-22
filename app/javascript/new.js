window.addEventListener('load',function price() {
  const priceinput = document.getElementById("item-price");
  const add_tax = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  priceinput.addEventListener('keyup',function () {
    const value = priceinput.value;
    if (value >= 300 && value <= 9999999) {
      let fee = value * 0.1
      let gains = value - fee
      add_tax.textContent = fee;
      profit.textContent = gains;
    }
  })
})
