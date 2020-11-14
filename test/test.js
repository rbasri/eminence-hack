const { assert } = require("chai");

describe("Exploit", function() {
  it("should run", async function() {
    const Exploit = await ethers.getContractFactory("Exploit");
    const exploit = await Exploit.deploy();
    await exploit.deployed();
    await exploit.run();
  });
});
