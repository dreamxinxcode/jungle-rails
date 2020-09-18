// [
//   { winner: 'Alice', loser: 'Bob',   loser_points: 3 },
//   { winner: 'Carol', loser: 'Dean',  loser_points: 1 },
//   { winner: 'Elise', loser: 'Bob',   loser_points: 2 },
//   { winner: 'Elise', loser: 'Carol', loser_points: 4 },
//   { winner: 'Alice', loser: 'Carol', loser_points: 2 },
//   { winner: 'Carol', loser: 'Dean',  loser_points: 3 },
//   { winner: 'Dean',  loser: 'Elise', loser_points: 2 },
// ]
// ￼
// ['Alice', 'Bob', 'Carol', 'Dean', 'Elise']

const names = (obj) => {
  let nameList = {};
  for (let set of obj) {
    nameList[set.winner] = null;
    nameList[set.loser] = null;
  }
  return Object.keys(nameList);
}

// {
//   'Alice': ['Bob', 'Carol'],
//   'Bob':   [],
//   'Carol': ['Dean'],
//   'Dean':  ['Elise'],
//   'Elise': ['Bob', 'Carol'],
// }

const beaten = (obj) => {
  let ans = {};
  for (let set of obj) {
    if (!obj[set.winner]) {
      obj[set.winner] = [set.loser];
    } else {
      obj[set.winner].push(obj[set].loser);
    }
    
    if (!obj[set.loser]) {
      obj[set.loser] = [];
    }
  }
  return ans;
}

// {
//   'Alice': [],
//   'Bob':   ['Alice', 'Elise'],
//   'Carol': ['Alice', 'Elise'],
//   'Dean':  ['Carol'],
//   'Elise': ['Dean']
// }


const enemies = (obj) => {
  let ans = {};
  
  for (let winner in obj) {
    for (let loser of obj[winner]) {
      if (ans[loser]) {
        ans[loser].push(winner);
      } else {
        ans[loser] = [winner];
      }

      if (!ans[winner]) {
        ans[winner] = [];
      }
    }
  }

  return ans;
};