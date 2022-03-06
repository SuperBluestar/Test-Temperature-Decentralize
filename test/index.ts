import { expect } from "chai";
import { ethers } from "hardhat";
import { Temperature } from "../typechain/Temperature";
import { Temperature__factory } from "../typechain/factories/Temperature__factory";

const oracleAddress = "0xc02a110Ae59C580a6d95e045Af53Fa63B226952b";

describe("Temperature", async function () {
  let temperature_factory: Temperature__factory;
  let temperature: Temperature;
  //@ts-ignore
  let owner, user1, user2;
  this.beforeAll(async function () {
    [owner, user1, user2] = await ethers.getSigners();
  });
  beforeEach(async function () {
    temperature_factory = (await ethers.getContractFactory("Temperature")) as Temperature__factory;
    temperature = await temperature_factory.deploy(oracleAddress);
    await temperature.deployed();
  });
  it("After Deployment, confirm the initical values of contract", async function () {
    
  });
  it("After Setting, confirm the status of contract", async function () {
    
  });
  it("After removing, confirm the status of contract",async function () {
    
  });
});
