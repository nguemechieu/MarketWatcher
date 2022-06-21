package org.tradeexperts.marketwhatcher;

import java.util.Date;

abstract class CUser {

    Long id;

    @Override
    public String toString() {
        return "CUser{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", email='" + email + '\'' +
                ", dateCreate='" + dateCreate + '\'' +
                ", dateUpdate='" + dateUpdate + '\'' +
                ", role=" + role +
                '}';
    }

    public CUser(Long id, String username, String password, String email, Date dateCreate, Date dateUpdate, ENUM_ROLE role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.dateCreate = dateCreate;
        this.dateUpdate = dateUpdate;
        this.role = role;
    }

    String username;
    String password;
    String email;
    Date dateCreate;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Date dateCreate) {
        this.dateCreate = dateCreate;
    }

    public Date getDateUpdate() {
        return dateUpdate;
    }

    public void setDateUpdate(Date dateUpdate) {
        this.dateUpdate = dateUpdate;
    }

    public ENUM_ROLE getRole() {
        return role;
    }

    public void setRole(ENUM_ROLE role) {
        this.role = role;
    }

    Date dateUpdate;
    ENUM_ROLE role;
}
