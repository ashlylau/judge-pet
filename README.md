# Judge Pet
50% of time taken to judge gymnstics is actually spent doing mental sums, which is 1) tiring. 2) error prone. This app fixes that. 

Written in Swift to make use of the Scribble API for handwriting recognition.


### V1
Table of TextFields with handwriting recognition, which uses: 
- number of valued elements
- number of Compositional Requirements
- total connection bonus
- total neutral deductions

To automatically calculate DV, D-score, E-score and Final score fields for ease of verification.

![V1 screenshot](/v1-demo.jpeg)


### Roadmap
- [ ] support for > F-valued skills
- [x] automatically calculate and display short exercise penalties
- [x] DV/D/E/Final Score fields
- [ ] separate writing space for scripting and deductions
- [ ] recognition and automatic calculation of E deductions
- [ ] different UI for VT and UB/BB/FX
- [ ] artistry/CR/CV reference
- [ ] file management capabilities


### Reference
[Women's Artistic Gymnastics 2022-2024 Code of Points](https://www.gymnastics.sport/publicdir/rules/files/en_WAG%20CoP%202022-2024.pdf)


### Archive
**MVP**
D-score table with handwriting recognition, which automatically computes the D-score from: 
- number of valued elements
- number of Compositional Requirements
- total connection bonus

![MVP screenshot](/mvp-demo.PNG)