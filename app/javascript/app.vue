<template>
  <div id="app">
    <form v-on:submit.prevent="searchForm">
      <!-- Ho usato prevent per prevenire la redirezione dovuta al submit del form -->
      <input type="text" v-model="term" placeholder="Cerca per termine"/>
      <button type="submit">Invio</button>
    </form>
    <post v-for="post in posts" :key="post.id" :post="post"></post>
  </div>
</template>

<script>
import Post from './components/Post'

export default {
  components: { Post },

  data() {
    return {
      posts: [],
      term: ""
    }
  },

  mounted() {
    fetch('/api/posts')
    .then(response => response.json())
    .then(data => {
      this.posts = data;
    })
  },

  methods:{
  
    searchForm: function(){
      fetch('/api/posts/filter?term=' + this.term)
      .then(response => response.json())
      .then(data => {
        this.posts = data;
      })
    }
  
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

form {
  padding: 1rem;
  margin: 2rem;
}
</style>
