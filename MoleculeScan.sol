// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0<0.9.0;


interface MoleculeFactory {

    function queryGeneralBatchStatus(uint [] memory _regionalId, address _reciever) external view returns(bool);
    function queryStatus(address user, address [] memory moleculeNftAddress ) external view returns(bool);
    function queryProviderBatchStatus(uint [] memory _batchId,address _reciever,address _provider) external view returns(bool);
}


contract MoleculeScan {

    // goerli testnet moleculeFactory Address
    address private constant  moleculeFactory = 0x4A15994dcdc0C52E2C4F6Ebb1A25cc761b05dDdF;

    modifier moleculeNftVerify(address [] memory _moleculeNftAddress){
        MoleculeFactory M = MoleculeFactory(moleculeFactory);
     bool status = M.queryStatus(msg.sender,_moleculeNftAddress);
      require(status == true, "Molecule Access Denied ");
      _;
  }

  modifier moleculeGeneralBatchVerify(uint [] memory _regionalId){
      MoleculeFactory M = MoleculeFactory(moleculeFactory);
      bool status = M.queryGeneralBatchStatus(_regionalId,msg.sender);
      require(status == false,"Molecule Access Denied");
      _;
  }

  modifier moleculeProviderBatchVerify(uint[] memory _batchId,address _provider){
      MoleculeFactory M = MoleculeFactory(moleculeFactory);
      bool status = M.queryProviderBatchStatus(_batchId,msg.sender,_provider);
      require(status == false,"Molecule Access Denied");
      _;
  }

}