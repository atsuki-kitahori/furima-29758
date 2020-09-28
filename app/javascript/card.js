const pay =  ()=> {
  Payjp.setPublicKey("pk_test_ddd00e2b8369b1e18275d2ac");
  const form = document.getElementById("charge-form");
  console.log(form)
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("number"),
      cvc: formData.get("cvc"),
      exp_month: formData.get("exp_month"),
      exp_year: `20${formData.get("exp_year")}`,
    };
    console.log(card);
  })
}
window.addEventListener("load", pay); 