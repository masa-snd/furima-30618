window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price")
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const addSalasProfit = document.getElementById("profit");
    if (inputValue >= 300 && inputValue <= 9999999) {
      addTaxPrice.innerHTML = Math.floor(inputValue * 0.1)
      addSalasProfit.innerHTML = inputValue - Math.floor(inputValue * 0.1)
    } else {
      addTaxPrice.innerHTML = NaN
      addSalasProfit.innerHTML = NaN
    }
 })
});