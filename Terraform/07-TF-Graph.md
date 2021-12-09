```
brew install graphviz
 terraform graph | dot -Tpdf > graph-plan.pdf
  terraform graph -type=plan-destroy | dot -Tpdf > graph-plan.pdf
```

<img width="322" alt="image" src="https://user-images.githubusercontent.com/75510135/145330716-32a1ce24-32c4-4546-bf33-ca7d3dd5d326.png">
