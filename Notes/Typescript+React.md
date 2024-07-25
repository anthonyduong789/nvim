### making a react typescript react game to learn

> the game will be a shooter game that will involve a block running dino runner
> it will avoid obstacles that are coming towards it and make sure to hop around those.

1. make a timer object that will pass the time to be used display a timer first with buttons toggle it whihc will then be used in the game!
2. second
3. third

### useMemo

- returns a memorized value similar to caching something so it doesn't need to be calculated

### useCallback

> what essentially this does is that it memoroize a functionupreventing it from being recreated on every render unless its dependencies change.
> this is beneficial for performance optimization as it prevents unnecessary re-renders of child components.

```tsx

```

##### Non-Null Asseertion Operator

> Asserts that a value is not null or undefined, overriding the TypeScript type checker.k

```TypeScript




```

### Using Type Inference in Generics

```typescript

type ReturnType<T> = T extends (...args: any[]) => infer R ? R : any;

// Usage
function greet(name: string): string {
    return `Hello, ${name}!`;
}

type GreetReturnType = ReturnType<typeof greet>; // string

// other examples

T extends U ? X : Y

type ReturnType<T> = T extends (...args: any[]) => infer R ? R : any;

// FunctionType is a type of a function that takes a number and a string as arguments and returns a boolean.
Using the ReturnType type alias, we extract the return type of FunctionType, which is boolean.

type FirstElement<T> = T extends [infer U, ...any[]] ? U : never;

type TupleType = [string, number, boolean];

type FirstElementType = FirstElement<TupleType>;
// FirstElementType is string

```

> helps you infer a type that is returned

```typescript
type FirstElement<T> = T extends [infer U, ...any[]] ? U : never;
```

### ^ breaking this down

> [!NOTE]
> This type definition is used to extract the type of the first element from a tuple type. Here’s a step-by-step explanation of each part:

Type Parameter (T):

T is a generic type parameter. It represents any type that will be passed to the FirstElement type alias.
Conditional Type (T extends [infer U, ...any[]] ? U : never):

This is a conditional type that checks if T matches a specific pattern.
Pattern Matching (T extends [infer U, ...any[]]):

This part checks if T is a tuple type.
The pattern [infer U, ...any[]] means:
infer U captures the type of the first element of the tuple and assigns it to U.
...any[] matches the rest of the elements in the tuple (regardless of their types and number).
Result (? U : never):

If T matches the pattern [infer U, ...any[]], then the conditional type resolves to U (the type of the first element).
If T does not match the pattern (i.e., T is not a tuple or is an empty tuple), then the conditional type resolves to never.

### leveraging conditional types

```typescript
type IsString<T> = T extends string ? true : false;

// Usage
const isStringResult: IsString<string> = true; // true
const isStringResult2: IsString<number> = false; // false
```

## Console

> Trace
> used for debugging that will help you trace the stack that the stack that was called

> dir
> better log for objects

> asserts
> log that expects true if false as first argument it will be log

> group
