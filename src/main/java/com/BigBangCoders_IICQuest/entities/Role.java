//package com.BigBangCoders_IICQuest.entities;
//
//import jakarta.persistence.*;
//import lombok.Getter;
//import lombok.NoArgsConstructor;
//import lombok.Setter;
//
//import java.util.HashSet;
//import java.util.Set;
//
//@Entity
//@Table(name = "roles")
//@NoArgsConstructor
//@Getter
//@Setter
//public class Role {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "role_id")
//    private int roleId;
//
//    @Column(name = "name")
//    private String name;
//
//    @ManyToMany(mappedBy = "roles", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
//    private Set<User> users = new HashSet<>();
//
//    // Constructors, getters, setters, etc.
//}
