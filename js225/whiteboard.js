function splitBunches(array) {
  let result = [];
  array.forEach(element => {
    for (let i = 0; i < element.quantity; i += 1) {
      result.push({ name: element.name.toLowerCase(), quantity: 1 });
    }
  });

  return result;
}

console.log(splitBunches([
  { name: "grapes", quantity: 2 }
 ]))

 console.log(splitBunches([
  { name: "GrApEs", quantity: 2 }
 ]))

console.log(splitBunches([
  { name: "currants", quantity: 1 },
  { name: "grapes", quantity: 2 },
  { name: "bananas", quantity: 2 }
]))

console.log(splitBunches([
  { name: "currants", quantity: 0 },
  { name: "grapes", quantity: 2.5 },
  { name: "bananas", quantity: 2 }
]))

