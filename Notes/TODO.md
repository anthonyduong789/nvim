### last text object -> inner and outer lop

<!-- TODO:  -->

> need to make a way to make sur vil is in loops
> commands it Nvim tree last text object or somethign

## currenty working on the seeAllTask

## steps

- get a example of the data you are working with
- pick a filter
- filter by that value and a arguement

#### Filter to work on

1. created by self
2. posted by self
3. created by a specific user
4. assigned to by a specific user
5. created by a manager user
6. assigned to by any manager

```javascript
// expected function should take in a list of input and return the same list but with the object filtered
// information
// make a global variable for all the function of the filter that will simply retrieve all the data
// each filter will basically take the function that it will make a copy to be returned keeping the global
// data the same but a new object for that specific filter

funtion(input){
  let filterData;
  filterData =  filter(input)

  output filterData;
}

```

manager

1. retrive data
2. get data with the filter id
   ^ check for each task if manager with hash map is that will by 2 \* O(n)
3.
