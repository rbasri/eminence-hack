const { assert } = require("chai");

describe("FlashLoan", function() {
  it("should run", async function() {
    const FlashLoan = await ethers.getContractFactory("FlashLoan");
    const flashLoan = await FlashLoan.deploy();
    await flashLoan.deployed();
    await flashLoan.myFlashLoanCall();
  });
});
