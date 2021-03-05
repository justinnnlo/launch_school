/*
1. Item creator

- SKU code (unique id)
  - first 3 letters of the item + first 2 letters of the category
  - If item is made of 2 words and the first is < 3 letters, get the extra letters from the category
- Item name: minimum of 5 characters (exclusive whitespaces) possibly across many words
- Category: minimum 5 characters and only 1 word
- Quantity: valid number provided (not blank, >= 0)

2. Items manager

- create — DONE
  - Input: name, category, quantity
  - Output: returns true if successful, false otherwise
  - Behavior: creates a new item and adds it to the list
- update: — DONE
  - Input: SKU code and object
  - Behavior: updates information on the item
  - E.g. { quantity: 5 } updates the quantity to 5
  - Assume valid inputs
- delete — DONE
  - Input: SKU code
  - Behavior: deletes item from the list
  - Assume valid SKU provided
  - Output: undefined
- items — DONE
  - Input: none
  - Output: returns list (array) of all the current items in the list (as obj)
- inStock — DONE
  - Input: None
  - Output: list all items with quantity > 0
- itemsInCategory — DONE
  - List all items in a category

  3. Reports manager

- init:
  - Input: ItemManager object
  - Behavior: assigns ItemManager to the items property
  - Returns undefined
- createReporter:
  - Input: SKU code
  - Output: object with Object.prototype as prototype (ie, using object literals)
    - ONe method to the object: itemInfo
    - itemInfo logs to the console the key value pairs (`${key}: ${value}`) of the item to the console
- reportInStock: logs to console all item NAMES that are in stock as CSV
  - E.g. basket ball, soccer ball, etc

Items need:

*/

const ItemManager = (() => {
  let items = [];

  function generateSKU(name, category) {
    // Generate the item's SKU
    return ((name.split(' ')[0].substr(0, 3) + category).substr(0, 5)).toUpperCase();
  }

  function validInputs(itemName, itemCategory, itemQuantity) {
    // Verify inputs are correct
    return itemName.replace(' ', '').length >= 5 && itemCategory.length >= 5 && !/ /.test(itemCategory) && itemQuantity >= 0;
  }

  function findItem(sku) {
    // Return the object of the item with the sku or false if it doesn't exist
    let filteredArray = items.filter(obj => obj.itemSKU === sku.toUpperCase());

    return !!filteredArray ? filteredArray[0] : false;
  }

  return {
    create(itemName, itemCategory, itemQuantity) {
      if (!validInputs(itemName, itemCategory, itemQuantity)) {
        // Return false if any inputs are incorrect

        return false;
      }
      let itemSKU = generateSKU(itemName, itemCategory);
      let existingObject = findItem(itemSKU);

      if (existingObject) {
        // If the item exists, add the quantity of the new object

        existingObject.itemQuantity += itemQuantity;
      } else {
        // If it doesn't, create and push the object to the array

        let item = {
          itemSKU,
          itemName,
          itemCategory,
          itemQuantity,
        };
        items.push(item);
      }
    },

    update(sku, obj) {
      let existingObject = findItem(sku);
      let regex = /^(itemName||itemCategory||itemQuantity)$/i

      if (existingObject) {
        let keys = Object.keys(obj);

        for (let i = 0; i < keys.length; i ++) {
          if (regex.test(keys[i])) {
            // If the key is valid update its value
            existingObject[keys[i]] = obj[keys[i]];
          }
        }
        // If the item object exists in the array return true
        return true;
      }

      // If the item object doesn't exist in the array return false
      return false;
    },

    delete(sku) {
      let existingObject = findItem(sku);

      if (existingObject) {
        // Remove the targeted item object from the array

        items.splice([items.indexOf(existingObject)], 1);
        return true;
      }

      // Return false if the item object doesn't exist
      return false;
    },

    inStock() {
      // Return an array of object with a quantity > 0
      return items.filter(obj => obj.itemQuantity > 0);
    },

    itemsInCategory(category) {
      // Return an array of object with the same category
      return items.filter(obj => obj.itemCategory === category);
    },

    items() {
      // Return the array of objects
      return items;
    }
  };
})();

const ReportManager = (() => {
  let items;
  // items is an object that returns an array of objects with items()
  // I want to filter for the object in the array with a specific SKU

  function findItem(sku) {
    // Return the object of the item with the sku or false if it doesn't exist
    let arrayOfObjects = items.items();
    let filteredArray = arrayOfObjects.filter(obj => obj.itemSKU === sku.toUpperCase());

    return !!filteredArray ? filteredArray[0] : false;
  }

  return {
    init(ItemManager) {
      // Bind the ItemManager to the items variable
      items = ItemManager;
      return this;
    },

    createReporter(sku) {
      let item = findItem(sku);
      console.log(`Item is: ${item}`)
      let itemKeys = Object.keys(item);
      return {
        itemInfo() {
          for (let i = 0; i < itemKeys.length; i ++) {
            console.log(`${itemKeys[i]}: ${item[itemKeys[i]]}`);
          }
        },
      };
    },

    reportInStock() {
      let itemsInStock = items.inStock();
      let names = [];

      for (let i = 0; i < itemsInStock.length; i ++) {
        names.push(itemsInStock[i].itemName);
      }

      return names.join(',')
    },
  };
})();

ItemManager.create('basket ball', 'sports', 0);           // valid item
ItemManager.create('asd', 'sports', 0);
ItemManager.create('soccer ball', 'sports', 5);           // valid item
ItemManager.create('football', 'sports');
ItemManager.create('football', 'sports', 3);              // valid item
ItemManager.create('kitchen pot', 'cooking items', 0);
ItemManager.create('kitchen pot', 'cooking', 3);          // valid item

console.log(ItemManager.inStock());
console.log(ItemManager.itemsInCategory('sports'));
console.log(ItemManager.itemsInCategory('sports'));
console.log(ItemManager.items());

// OK until here

console.log(ReportManager.init(ItemManager));
console.log(ReportManager.reportInStock());
// // // logs soccer ball,football,kitchen pot

console.log(ItemManager.update('SOCSP', { itemQuantity: 0 }));
console.log(ItemManager.inStock());
// // // returns list with the item objects for football and kitchen pot


console.log(ReportManager.reportInStock());
// // // logs football,kitchen pot

console.log(ItemManager.itemsInCategory('sports'));
// // // returns list with the item objects for basket ball, soccer ball, and football

console.log(ItemManager.delete('SOCSP'));
console.log(ItemManager.items());
// // // returns list with the remaining 3 valid items (soccer ball is removed from the list)

const kitchenPotReporter = ReportManager.createReporter('KITCO');
console.log(kitchenPotReporter);
kitchenPotReporter.itemInfo();
// // logs
// // skuCode: KITCO
// // itemName: kitchen pot
// // category: cooking
// // quantity: 3

ItemManager.update('KITCO', { itemQuantity: 10 });
kitchenPotReporter.itemInfo();
// // logs
// // skuCode: KITCO
// // itemName: kitchen pot
// // category: cooking
// // quantity: 10


const ItemCreator = (() => {
  function generateSkuCode(itemName, category) {
    return (itemName.replace(/\s/g, '').slice(0, 3).toUpperCase() +
            category.replace(/\s/g, '').slice(0, 2).toUpperCase());
  }

  function isValidItemName(itemName) {
    return itemName.replace(/\s/g, '').length >= 5;
  }

  function isValidCategory(category) {
    return category.replace(/\s/g, '').length >= 5 && category.split(' ').length === 1;
  }

  function isQuantityProvided(quantity) {
    return quantity !== undefined
  }

  return function(itemName, category, quantity) {
    if (isValidItemName(itemName) && isValidCategory(category) && isQuantityProvided(quantity)) {
      this.skuCode = generateSkuCode(itemName, category);
      this.itemName = itemName;
      this.category = category;
      this.quantity = quantity;
    } else {
      return { notValid: true };
    }
  };
})();

const ItemManager = {
  items: [],
  getItem(skuCode) {
    return this.items.filter(item => item.skuCode === skuCode)[0];
  },

  create(itemName, category, quantity) {
    const item = new ItemCreator(itemName, category, quantity);
    if (item.notValid) {
      return false;
    } else {
      this.items.push(item);
    }
  },

  update(skuCode, itemInformation) {
    Object.assign(this.getItem(skuCode), itemInformation);
  },

  delete(skuCode) {
    this.items.splice(this.items.indexOf(this.getItem(skuCode)), 1);
  },

  list() {
    return this.items;
  },

  inStock() {
    return this.items.filter(({quantity}) => quantity > 0);
  },

  itemsInCategory(category) {
    return this.items.filter(item => item.category === category);
  },
};

const ReportManager = {
  init(itemManager) {
    this.items = itemManager;
  },

  createReporter(skuCode) {
    return (() => {
      const item = this.items.getItem(skuCode);
      return {
        itemInfo() {
          Object.keys(item).forEach(key => {
            console.log(`${key}: ${item[key]}`);
          });
        },
      };
    })();
  },

  reportInStock() {
    console.log(this.items.inStock().map(({itemName}) => itemName).join(','))
  },
};