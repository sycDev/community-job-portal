package com.abcjobs.auth;

import com.abcjobs.config.JpaConfig;
import com.abcjobs.config.SecurityConfig;
import com.abcjobs.config.WebMvcConfig;
import org.hamcrest.CoreMatchers;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.test.context.support.WithAnonymousUser;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={WebMvcConfig.class, JpaConfig.class, SecurityConfig.class})
@WebAppConfiguration
public class SecurityConfigTest {
    private MockMvc mockMvc;

    @Autowired
    private WebApplicationContext context;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(context).apply(springSecurity()).build();
    }

    @Test
    @WithMockUser(username = "Jennifer", roles={"SOFTWARE_PROGRAMMER"})
    public void testSoftwareProgrammerAccessToUserHomePageEndpoint() throws Exception {
        this.mockMvc.perform(MockMvcRequestBuilders.get("/home"))
                .andDo(print()).andExpect(status().isOk());
    }

    @Test
    @WithMockUser(username = "Ashley", roles={"ADMINISTRATOR"})
    public void testAdministratorAccessToUserHomePageEndpoint() throws Exception {
        this.mockMvc.perform(MockMvcRequestBuilders.get("/home"))
                .andDo(print()).andExpect(status().isForbidden());
    }

    @Test
    @WithMockUser(username = "Melissa", roles={"ADMINISTRATOR"})
    public void testAdministratorAccessToAdminUsersEndpoint() throws Exception {
        this.mockMvc.perform(MockMvcRequestBuilders.get("/admin/users"))
                .andDo(print()).andExpect(status().isOk());
    }

    @Test
    @WithMockUser(username = "Jessica", roles={"SOFTWARE_PROGRAMMER"})
    public void testSoftwareProgrammerAccessToAdminUsersEndpoint() throws Exception {
        this.mockMvc.perform(MockMvcRequestBuilders.get("/admin/users"))
                .andDo(print()).andExpect(status().isForbidden());
    }

    @Test
    @WithMockUser(username = "Nicole", roles={"SOFTWARE_PROGRAMMER"})
    public void testSoftwareProgrammerAccessToViewProfileEndpoint() throws Exception {
        this.mockMvc.perform(MockMvcRequestBuilders.get("/viewProfile"))
                .andDo(print()).andExpect(status().isOk());
    }

    @Test
    @WithMockUser(username = "Sarah", roles={"ADMINISTRATOR"})
    public void testAdministratorAccessToViewProfileEndpoint() throws Exception {
        this.mockMvc.perform(MockMvcRequestBuilders.get("/viewProfile"))
                .andDo(print()).andExpect(status().isForbidden());
    }

    @Test
    @WithAnonymousUser
    public void testUnauthorizedUserAccessToAdminUsersEndpoint() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/admin/users"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @WithAnonymousUser
    public void testUnauthorizedUserAccessToUserHomePageEndpoint() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/home"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @WithAnonymousUser
    public void testUnauthorizedUserAccessToProfilePageEndpoint() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/viewProfile"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @WithMockUser(username = "Tim", roles={"SOFTWARE_PROGRAMMER"})
    public void testSoftwareProgrammerAccessToLandingPageEndpoint() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/"))
                .andExpect(status().isFound())
                .andExpect(header().string("Location", CoreMatchers.containsString("/home")));
    }

    @Test
    @WithMockUser(username = "Abigail", roles={"ADMINISTRATOR"})
    public void testAdministratorAccessToLandingPageEndpoint() throws Exception {
        mockMvc.perform(MockMvcRequestBuilders.get("/"))
                .andExpect(status().isFound())
                .andExpect(header().string("Location", CoreMatchers.containsString("/admin/")));
    }
}