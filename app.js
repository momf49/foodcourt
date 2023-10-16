// Add your JavaScript code here

document.addEventListener("DOMContentLoaded", function () {
  // DOM is ready, you can initialize your JavaScript code here
  console.log("DOM is ready");

  // Example code to interact with the Solidity contract
  const contractAddress = "0x123456789abcdef"; // Replace with your contract address
  const contractABI = [
    // Replace with your contract's ABI
    // ... contract ABI goes here ...
  ];

  // Example code to interact with the contract functions
  const web3 = new Web3(Web3.givenProvider || "http://localhost:8545");
  const contract = new web3.eth.Contract(contractABI, contractAddress);

  // Example code to call a contract function
  async function addMenuItem(name, country, price) {
    try {
      const accounts = await web3.eth.getAccounts();
      await contract.methods.addMenuItem(name, country, price).send({
        from: accounts[0],
      });
      console.log("MenuItem added successfully");
    } catch (error) {
      console.error("Failed to add MenuItem:", error);
    }
  }

  // Example code to handle form submission
  const form = document.getElementById("addMenuItemForm");
  form.addEventListener("submit", function (event) {
    event.preventDefault();
    const nameInput = document.getElementById("name");
    const countryInput = document.getElementById("country");
    const priceInput = document.getElementById("price");

    const name = nameInput.value;
    const country = countryInput.value;
    const price = parseInt(priceInput.value);

    addMenuItem(name, country, price);
  });
});