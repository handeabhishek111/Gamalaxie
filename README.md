# arcade-card-game

## How to run the project: 

### Clone the repo and do the following steps
- Ensure you havea mongo db database conneced 
(db name: ngc, colection name: duel, queue)

```
% npm i
% npm run start:dev
```

###  In this game main focus is to prevent the blocks from stacking up to the top of the screen for as long as possible.Solving the puzzle to earn points.The score is used for dueling .Then you can duel with other players for a staking amount which you would get doubled if your nft has higher scores than your opponent.
### This project uses a simple game, which is tetris, tetris blocks are falling from top down which aligned correctly removes them which gives you points . We are trying to implement this on blockchain.
### When the blocks cannot be moved any further the score is reached for a user and the game is over, then he/she can create an Scorecard based NFT using the same score. Those cards can be further used in a duel which will be done on the blockchain.
