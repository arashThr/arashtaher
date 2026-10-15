+++
title = 'Python Refresher 2026'
date = '2026-10-15T13:06:57+02:00'
tags = ["python", "programming", "guide", "summary"]
+++

I haven't done much programming with Python since version 2.7. Here's a couple of notable examples and concepts that I'd like to keep as a reminder.

Here are the highlights for me after going through [Learn X in Y minutes](https://learnxinyminutes.com/python/) and [Python Cheatsheet](https://gto76.github.io/python-cheatsheet/):

``` python
## 1. Primitive Datatypes and Operators

# True and False are actually 1 and 0 but with different keywords
True + True  # => 2
0 == False   # => True

1 < 2 < 3  # => True

"Hello " "world!"    # => "Hello world!"

# f-strings
name = "Reiko"
f"{name} is {len(name)} characters long."

# None is an object. Use "is", and NOT "==" to check for equality of object identity.
None is None   # => True

## 2. Variables and Collections
input_string_var = input("Enter some data: ")

some_unknown_var  # Raises a NameError

## Lists

li = [1, 2, 3]
li[::-1]  # [3, 2, 1]
li2 = li[:] # Shallow copy
li.index(5)  # Raises a ValueError
1 in li  # => True

## Tuples

# Tuples are like lists but are immutable.
tup = (1, 2, 3)
tup[0] = 3  # Raises a TypeError
type((1))   # => <class 'int'>
type((1,))  # => <class 'tuple'>
a, *b, c = 1, 2, 3, 4  # b is now [2, 3]

## Dictionaries

filled_dict = {"one": 1, "two": 2, "three": 3}
# Keys have to be of immutable types for quick look-up: ints, floats, strings, tuples
invalid_dict = {[1,2,3]: "123"}  # => Yield a TypeError: unhashable type: 'list'
# Keys and values insert order is preserved in Python 3.7+
list(filled_dict.keys())  # ["three", "two", "one"] in Python <3.7

filled_dict["four"]  # KeyError
filled_dict.get("four")     # => None

{"a": 1, **{"a": 2}}  # => {'a': 2} unpacking options

## Sets

invalid_set = {[1], 1}  # => Raises a TypeError: unhashable type: 'list'
valid_set = {(1,), 1}
# Operations: & | - ^ >= <=

## 3. Control Flow and Iterables

# match
command = "run"
match command:
    case "run": print("The robot started to run 🏃‍♂️")
    case _:  print("Invalid command ❌")
    
# enumerate
animals = ["dog", "cat", "mouse"]
for i, value in enumerate(animals):
    print(i, value)
    
# Iterables
filled_dict = {"one": 1, "two": 2, "three": 3}
our_iterable = filled_dict.keys()
our_iterable[1]  # Raises a TypeError
# An iterable is an object that knows how to create an iterator.
our_iterator = iter(our_iterable)
next(our_iterator)  # => "one"... and then ->
next(our_iterator)  # Raises StopIteration

## 4. Functions

# Splat operator * and splatty-splat **
def all_the_args(*args, **kwargs): pass # positional arguments (tuples) and keyword arguments

# Closures in nested functions:
def create_avg():
    total = 0
    count = 0
    def avg(n):
        # Reading an outer variable works without declaration, but any assignment requires nonlocal (or global)
        # Otherwise: `UnboundLocalError: cannot access local variable 'total' where it is not associated with a value`
        nonlocal total, count
        total += n
        count += 1
        return total/count
    return avg

avg = create_avg()
avg(3)  # => 3.0
avg(5)  # (3+5)/2 => 4.0

list(map(max, [1, 2, 3], [4, 2, 1, 6]))  # => [4, 2, 3]

# Set comprehension
{x for x in "abcddeef" if x not in "abc"}  # => {'d', 'e', 'f'}

## 5. Modules

# Find out which functions and attributes are defined in a module.
import math
dir(math)

## Classes

class Human:
    # Class attribute
    species = "H. sapiens"
    # Methods, objects or attributes like: __init__, __repr__ etc. are called special methods (or dunder methods)
    def __init__(self, name):
        self.name = name
        self._age = 0
    @classmethod
    def get_species(cls):
        return cls.species
    @staticmethod
    def grunt():
        return "*grunt*"
    @property
    def age(self):
        return self._age
    @age.setter
    def age(self, age):
        self._age = age
    @age.deleter
    def age(self):
        del self._age

i = Human(name="Ian")
i.say(i.age)
del i.age
# i.age # => this would raise an AttributeError

# Inheritance
class Superhero(Human): pass

if isinstance(sup, Human): print("I am human")
if type(sup) is Superhero: print("I am a superhero")

# Get the "Method Resolution Order" used by both getattr() and super()
print(Superhero.__mro__) # => (<class '__main__.Superhero'>, <class 'human.Human'>, <class 'object'>)

## 7. Advanced

# Generator comprehensions as well.
values = (-x for x in [1,2,3]) # <class 'generator'>
for x in values: print(x)  # prints -1 -2 -3

# Decorators
from functools import wraps

def log_function(func):
    @wraps(func)  # this ensures docstring, function name, arguments list, etc. are all copied
                  # to the wrapped function - instead of being replaced with wrapper's info
    def wrapper(*args, **kwargs):
        print("Entering function", func.__name__)
        result = func(*args, **kwargs)
        print("Exiting function", func.__name__)
        return result
    return wrapper

@log_function
def my_function(x,y):
    """Adds two numbers together."""
    return x+y
```

- Methods that are decorated with `@staticmethod` receive neither `self` nor `cls` arg.
- `__repr__` should be unambiguous string representation of an object. Ideally return a string that looks like valid Python code capable of recreating the object
