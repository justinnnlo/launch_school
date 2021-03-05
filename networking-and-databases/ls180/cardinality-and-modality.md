Cardinality: number of objects on each side of the relationship
  - 1:1, 1:M, M:M
Modality: determines if the relationship is optional (0) or required (1)
  - Lower bound on how many instances can exist in a relationship

Illustrating database diagram cardinality relationships:
- Horizontal line with single vertical line: 1:1 cardinality
- Horizontal line with 3 lines at its end (one side): 1:M cardinality
- Horizontal line with 3 lines at its end (both sides): M:M cardinality

Illustrating database diagram modality relationships:
- Circle in line: optional modality
- Vertical line: required modality

What is cardinality?
- MR: Cardinality is the number of sides in a relationship
- Correction: Cardinality is the **number of instances in each side** of the relationship

What is modality?
- MR: Modality is whether a relationship is optional or not. Do you need both sides to have an entity?
- Correction: Modality indicates whether a relationship is optional or not
  - Got the spirit right but should¡ve been more precise ("indicates" rather than "is whether")

If one side of a relationship has a modality of 1, what is the smallest number of instances that can be on that side of the relationship?
- MR: If a side of a relationship has a modality of 1, the smallest number of instances on that side is the number of instances on the other side
- Correction: 1 — **WHY**?

Notation system used: crow's foot notation