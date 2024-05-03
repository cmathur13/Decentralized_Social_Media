pragma solidity >=0.5.0 <0.9.0;

contract Decentragram {
    string public name = "Decentragram";

    struct Image{
      uint id;
      string hash;
      string description;
      uint tipAmount;
      address payable author;
    }


    //event is created
    event ImageCreated(
      uint id,
      string hash,
      string description,
      uint tipAmount,
      address payable author
    );


    //store the image
    uint public imageCount = 0;
    mapping(uint => Image) public images;

    //create the image
    function uploadImage(string memory _imagehash, string memory _description)public {

      //make sure description exist and hashexist and adress is correct
      require(bytes(_description).length > 0);
      require(bytes(_imagehash).length > 0);
      require(msg.sender != address(0x0));

      //incrment image count 
      imageCount++;

      //add image to the contract
      images[imageCount] = Image(imageCount, _imagehash , _description , 0 , msg.sender);
      
    }

    //tip the image
    function tipImageOwner(uint _id)public payable{

      require(_id > 0 && _id <= imageCount);

      //trasfer money to author of image
      Image memory image = images[_id];

      //fetch the author
      address payable author = image.author;

      //pay the author by sendeing them ether
      (author).transfer(msg.value);

      //update the tip amount
      image.tipAmount = image.tipAmount + msg.value;

      //update the image 
      images[_id] = image;
    }

}