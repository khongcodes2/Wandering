# Seeds
## Progress
- [x] stubbed

| Check | Progress | Spaces | Items |
| ----- | -------- | ------ | ----- |
| [ ] | 25%  | 3.5  regions | 15 items |
| [ ] | 50%  | 7    regions | 30 items |
| [ ] | 75%  | 10.5 regions | 45 items |
| [ ] | 100% | 14   regions | 60 items |

## Seed writing
|     type          | noun  | adjective |
| ----------------- | ----  | --------- |
| Items             | 36/40 |   34/40   |
| Lab               |  0/40 |    0/40   |
| Underground City  |  0/40 |    0/40   |
| Beach             |  0/40 |    0/40   |
| Underwater        | 21/40 |   12/40   |
| Cave              |  0/40 |    0/40   |
| Forest            | 31/40 |   18/40   |
| Ruins             |  0/40 |    0/40   |
| Plain             |  0/40 |    0/40   |
| Marsh             |  0/40 |    0/40   |
| Desert            | 22/40 |   12/40   |
| Taiga             |  0/40 |    0/40   |
| Tundra            |  0/40 |    0/40   |
| Mountain          |  0/40 |    0/40   |

## Probabilities
- 70% to enter space 4 without triggering journey-end sequence
- 50% to enter space 5
- 30% to enter space 6
- 20% to enter space 7
- 10% to enter space 8
-  0% to enter space 9

## Refactoring wishlist
- [ ] Journey and Item have each other through memories
  - [ ] only show in sidebar, only allow item_drop if item being_held TRUE
  - [ ] journey scope method num_items_held, for pickup constraint

- [ ] Journey and Space have each other through memories
  - [ ] DRY out and organize code for spaces#show
    - [ ] Lay out the different conditions in which the page would be accessed; handler for each one
  - [ ] remove non-namespaced space#show paths

## Future features
- Npcs/followers/pets
- Random events